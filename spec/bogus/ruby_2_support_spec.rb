require 'spec_helper'

if RUBY_VERSION >= '2.0'
  describe "Ruby 2.0 keyword arguments" do
    class ExampleForKeywordArgs
      eval "def foo(x: raise, y: 1); end"
      eval "def bar(x: 1, **rest); end"
    end

    include Bogus::MockingDSL

    context "with regular objects" do
      subject { ExampleForKeywordArgs.new }

      include_examples "stubbing methods with keyword arguments"
      include_examples "stubbing methods with double splat"
    end

    context "with fakes" do
      subject { fake(:example_for_keyword_args) }

      it "allows spying without stubbing" do
        subject.foo(x: "test")

        subject.should have_received.foo(x: "test")
      end

      include_examples "stubbing methods with keyword arguments"
      include_examples "stubbing methods with double splat"
    end
  end
end
