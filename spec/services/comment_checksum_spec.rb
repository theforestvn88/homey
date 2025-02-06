require "rails_helper"

RSpec.describe CommentChecksum, type: :service do
    describe "comment checksum" do
        it "use md5" do
            expected = "comment-checksum"
            allow_any_instance_of(Digest::MD5).to receive(:hexdigest).and_return(expected)

            expect(
                CommentChecksum.new.create(Faker::Lorem.characters(number: 20))
            ).to eq(expected)
        end
    end
end
