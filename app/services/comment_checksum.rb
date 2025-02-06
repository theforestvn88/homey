# frozen_string_literal: true

class CommentChecksum
    Result = Struct.new(:success, :data, :errors)

    def create(text)
        md5 = Digest::MD5.new
        md5 << text
        md5.hexdigest
    end
end
