"""Synchronize browser input with Flutter's accessibility focus handoff."""
from playwright.sync_api import expect


def fill_flutter_field(page, field, value):
    # Semantics input nodes can exist before Flutter has activated editing.
    # Focus first, let its semantics frame and activation frame complete, then
    # enter once. Never retry/refill silently after a value is lost.
    field.click()
    expect(field).to_be_focused()
    frame_barrier = '() => new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)))'
    page.evaluate(frame_barrier)
    field.fill(value)
    page.evaluate(frame_barrier)
    if field.input_value() != value:
        raise AssertionError('Flutter field did not retain the supplied synthetic value after focus activation')
