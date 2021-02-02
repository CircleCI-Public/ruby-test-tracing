require "honeycomb-beeline"

## Some imaginary common test setup that has been instrumented
def setup_db
  Honeycomb.start_span(name: "setup_db") do
    run_migrations
    reset_db
  end
end

def run_migrations
  Honeycomb.start_span(name: "run_migrations") do
    sleep 0.3
  end
end

def reset_db
  Honeycomb.start_span(name: "reset_db") do
    sleep 0.1
  end
end
