/* Direct-ELF experiment entry. Test, startup, ISR dispatch, logging and status
 * reporting use the pinned official OpenTitan implementations. */
#include "sw/device/lib/runtime/print.h"
#include "sw/device/lib/testing/test_framework/ottf_main.h"
#include "sw/device/lib/testing/test_framework/status.h"

void _ottf_main(void) {
  /* Diagnostic printf may discard text: official DV LOG messages remain visible
   * at the device log window, without introducing a UART dependency. */
  base_set_stdout((buffer_sink_t){0});
  test_status_set(kTestStatusInTest);
  bool success = test_main();
  test_status_set(success ? kTestStatusPassed : kTestStatusFailed);
}
