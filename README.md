# RSpec Honeycomb instrumentation

This test suite sends all example groups and examples as spans to Honeycomb,
grouped under a common top-level root span.

## Example output

When you run the suite, you should get traces similar to the following:

![](example-trace.png)