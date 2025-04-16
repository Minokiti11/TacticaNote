class Video < ApplicationRecord
    has_one_attached :video

    has_many :notes, dependent: :nullify
    has_many :timestamps, dependent: :nullify

    belongs_to :user, optional: true
    belongs_to :group, optional: true

    validate :acceptable_video

    def thumbnail
        return unless video.content_type.starts_with?('video/')
    
        video.representation(resize_to_limit: [640, 360], format: 'jpg').processed
    end
    
    private

    def acceptable_video
        return unless video.attached?

        acceptable_types = ['video/mp4', 'video/webm']
        unless acceptable_types.include?(video.content_type)
            errors.add(:video, 'はMP4またはWebM形式でアップロードしてください')
        end
    end
end
