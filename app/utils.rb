#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#


FOREVER = -1


class AllAttemptsFailed < StandardError

  def initialize(max_attempts)
    @max_attempts = max_attempts
  end

  def message
    "All {#@max_attempts} attempts have failed!"
  end
  
end


def with_retry (max_attempts=10, backoff=20)

  attempt = 0

  begin
    attempt += 1
    yield
    
  rescue Exception => error
    sleep(backoff)
    retry unless max_attempts > 0 and attempt >= max_attempts
    raise AllAttemptsFailed.new(max_attempts)
    
  end
  
end
