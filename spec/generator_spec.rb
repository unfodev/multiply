require 'spec_helper'

module Multiply
  describe Generator do
    let(:mock_words) { double(
      Words,
      :all => WrapArray.new(
        %w{This is a long text. text longer than the short shorter}
        #   0   1  2  3    4     5    6     7     8    9    10
        #   11  12 13 14   15    16   17    18    19   20   21
        #   22  23 24 25   26    27   28   29      30  31   32
      )
    )}

    before(:each) do
      Words.stub(:new).and_return(mock_words)
    end

    subject { Generator.new(*text_strings) }

    its(:formatter)  { should be_a(Formatter) }
    its(:multiplier) { should be_a(Multiplier) }

    describe "#generate" do
      context "1 passed in" do
        subject { Generator.new(*text_strings).generate(1) }

        it { should == "This" }
      end

      context "2 passed in" do
        subject { Generator.new(*text_strings).generate(2) }

        it { should == "This text" }
      end

      context "9 passed in" do
        subject { Generator.new(*text_strings).generate(9) }

        it { should == "This text a the longer This text. text. This" }
      end
    end

  end
end

