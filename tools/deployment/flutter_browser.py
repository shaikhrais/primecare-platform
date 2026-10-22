"""Synchronize browser input with Flutter's accessibility focus handoff."""
from playwright.sync_api import expect


def fill_flutter_field(page, field, value):
    # Semantics input nodes can exist before Flutter has activated editing.
    # Focus and scroll can outlast two frames on a narrow Flutter web form.
    # Wait for the focused input to settle, then send ordinary key events once.
    # Never retry/refill silently after a value is lost.
    field.click()
    expect(field).to_be_focused()
    field.evaluate('''element => new Promise((resolve, reject) => {
      const deadline = performance.now() + 5000;
      let previous, settledAt = performance.now();
      function frame() {
        const now = performance.now(), box = element.getBoundingClientRect();
        const focused = element.matches(':focus');
        const position = [box.x, box.y, box.width, box.height].join(',');
        if (!focused || position !== previous) settledAt = now;
        previous = position;
        if (element.isConnected && focused && now - settledAt >= 250) return resolve();
        if (!element.isConnected || now >= deadline) return reject(new Error('Auth input focus did not settle'));
        requestAnimationFrame(frame);
      }
      requestAnimationFrame(frame);
    })''')
    frame_barrier = '() => new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)))'
    field.fill('')
    page.evaluate(frame_barrier)
    field.press_sequentially(value, delay=10)
    page.evaluate(frame_barrier)
    if field.input_value() != value:
        raise AssertionError('Flutter field did not retain the supplied synthetic value after focus activation')
