require 'lib/ruby_test'
require 'rspec/autorun'

describe "#create_matrix" do
  context "given empty string" do
    it "returns zero" do
      expect(add("")).to eq(0)
    end
  end
end