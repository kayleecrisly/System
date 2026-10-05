#!/usr/bin/env python3
"""Verify the recorded System layout, generated artifacts and external archives."""
import hashlib
import json
import os
from pathlib import Path


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def main():
    system = Path(__file__).resolve().parents[2]
    layout = json.loads((system / '.layout.json').read_text())
    record = json.loads(Path(layout['integrity_manifest']).read_text())
    errors = []
    for path, expected in record['preserved_files'].items():
        p = Path(path)
        if not p.is_file() or digest(p) != expected:
            errors.append(f'File missing or changed: {path}')
    for path, target in record['symlinks'].items():
        p = Path(path)
        if not p.is_symlink() or os.readlink(p) != target or not p.exists():
            errors.append(f'Link missing, changed or broken: {path}')
    for path in record['removed_entries']:
        p = Path(path)
        if p.exists() or p.is_symlink():
            errors.append(f'Obsolete entry recreated: {path}')
    # Model deliverables must not accumulate firmware binaries or diagnostics.
    misplaced = {'.elf', '.bin', '.hex', '.o', '.log', '.mlir'}
    outputs = system / 'outputs'
    for path in outputs.rglob('*'):
        if path.is_file() and path.suffix in misplaced:
            errors.append(f'Non-model artifact in outputs: {path}')
    # A split generation records separate hashes for models and diagnostics.
    for manifest in outputs.rglob('manifest.lock.json'):
        data = json.loads(manifest.read_text())
        for relative, expected in data.get('artifact_sha256', {}).items():
            path = manifest.parent / relative
            if not path.is_file() or digest(path) != expected:
                errors.append(f'Generated artifact missing or changed: {path}')
        if 'results_dir' in data:
            result_dir = manifest.parent / data['results_dir']
            for relative, expected in data.get('generation_sha256', {}).items():
                path = result_dir / relative
                if not path.is_file() or digest(path) != expected:
                    errors.append(f'Generation evidence missing or changed: {path}')
    print(json.dumps({'preserved_files_checked': len(record['preserved_files']),
                      'errors': errors, 'status': 'fail' if errors else 'pass'},
                     indent=2, ensure_ascii=False))
    raise SystemExit(bool(errors))


if __name__ == '__main__':
    main()
