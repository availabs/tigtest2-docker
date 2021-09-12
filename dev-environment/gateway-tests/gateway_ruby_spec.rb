# Runs the tigtest2-docker dev-environment gateway-tests suite
#   If the gateway-tests fail, the Ruby RSpec tests fail.
#   This file must be mounted in the docker dev-env container.

RSpec.describe "gateway-tests-suite" do
  it "runs the gateway-tests" do
    system("/home/deploy/gateway-tests/run-tests") or raise "FAIL"
  end
end
