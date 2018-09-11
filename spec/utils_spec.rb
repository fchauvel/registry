#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#



require "spec_helper.rb"

require "rspec"

require "./app/utils.rb"



describe "with_retry" do

  before do
    @obj = double("obj")
  end

  context "when the function always fails" do

    it "retries a specific number of time and eventually raises" do
      allow(@obj)
        .to receive(:say_hello).and_raise("Failed!")
       
       expect(@obj).to receive(:say_hello).exactly(3).times()

       expect {
         with_retry(3, 1) {
           @obj.say_hello(5)
         }
      }.to raise_error(AllAttemptsFailed)
    end
    
  end

  context "when the function fails only once" do

    it "retry only once" do
      counter = 0
      allow(@obj).to receive(:say_hello) do
        counter +=1
        raise "Failed" unless counter > 1
      end
      
       expect(@obj).to receive(:say_hello).exactly(2).times()
       
       with_retry(3, 1) {
         @obj.say_hello(5)
       }
    end
    
  end

end



