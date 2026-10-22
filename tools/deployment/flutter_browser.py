"""Synchronize browser interaction with Flutter's accessibility handoff."""
from playwright.sync_api import expect


def _settle_flutter_control(control, *, focused=False):
    control.evaluate('''(element, requireFocus) => new Promise((resolve, reject) => {
      const deadline = performance.now() + 5000;
      let previous, settledAt = performance.now();
      function frame() {
        const now = performance.now(), box = element.getBoundingClientRect();
        const ready = !requireFocus || element.matches(':focus');
        const position = [box.x, box.y, box.width, box.height].join(',');
        if (!ready || position !== previous) settledAt = now;
        previous = position;
        if (element.isConnected && ready && box.width > 0 && box.height > 0 && now - settledAt >= 250) return resolve();
        if (!element.isConnected || now >= deadline) return reject(new Error('Flutter control position or focus did not settle'));
        requestAnimationFrame(frame);
      }
      requestAnimationFrame(frame);
    })''', focused)


def click_flutter_control(control):
    # Browser scrollIntoView can precede Flutter's canvas scroll frame. Clicking
    # immediately can focus a different canvas field even when DOM bounds match.
    control.scroll_into_view_if_needed()
    _settle_flutter_control(control)
    control.click()


def fill_flutter_field(page, field, value):
    # Enter once after scroll and focus settle; never refill lost input silently.
    click_flutter_control(field)
    expect(field).to_be_focused()
    _settle_flutter_control(field, focused=True)
    frame_barrier = '() => new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)))'
    field.fill('')
    page.evaluate(frame_barrier)
    field.press_sequentially(value, delay=10)
    page.evaluate(frame_barrier)
    if field.input_value() != value:
        raise AssertionError('Flutter field did not retain the supplied synthetic value after focus activation')
