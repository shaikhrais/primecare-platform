"""Synchronize browser interaction with Flutter's accessibility handoff."""
from playwright.sync_api import expect


def _settle_flutter_control(control, *, focused=False):
    return control.evaluate('''(element, requireFocus) => new Promise((resolve, reject) => {
      const deadline = performance.now() + 5000;
      let previous, settledAt = performance.now();
      function frame() {
        const now = performance.now(), box = element.getBoundingClientRect();
        const ready = !requireFocus || element.matches(':focus');
        const position = [box.x, box.y, box.width, box.height].join(',');
        if (!ready || position !== previous) settledAt = now;
        previous = position;
        if (!element.isConnected) return resolve(false);
        if (ready && box.width > 0 && box.height > 0 && now - settledAt >= (requireFocus ? 250 : 600)) return resolve(true);
        if (now >= deadline) return reject(new Error('Flutter control position or focus did not settle'));
        requestAnimationFrame(frame);
      }
      requestAnimationFrame(frame);
    })''', focused)


def click_flutter_control(control):
    # Browser scrollIntoView can precede Flutter's canvas scroll frame. Clicking
    # immediately can focus a different canvas field even when DOM bounds match.
    # A verified session restoration can replace the semantics node while it
    # settles. Re-resolve only before the single click; never retry an action.
    for _ in range(3):
        control.wait_for(state='visible')
        control.scroll_into_view_if_needed()
        if _settle_flutter_control(control):
            control.click()
            return
    raise AssertionError('Flutter control was replaced repeatedly before interaction')


def fill_flutter_field(page, field, value):
    # Enter once after scroll and focus settle; never refill lost input silently.
    click_flutter_control(field)
    expect(field).to_be_focused()
    if not _settle_flutter_control(field, focused=True):
        raise AssertionError('Flutter field was replaced after focus; no proof entered')
    frame_barrier = '() => new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)))'
    field.fill('')
    page.evaluate(frame_barrier)
    field.press_sequentially(value, delay=10)
    page.evaluate(frame_barrier)
    if field.input_value() != value:
        raise AssertionError('Flutter field did not retain the supplied synthetic value after focus activation')
