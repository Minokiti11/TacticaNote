class Video < ApplicationRecord
    has_one_attached :video

    has_many :notes, dependent: :nullify
    has_many :timestamps, dependent: :nullify

    belongs_to :user, optional: true
    belongs_to :group, optional: true

    validate :acceptable_video

    def thumbnail
        if video.video.attached? && video.video.previewable?
            video = Video.last
            video.video.content_type
            video.video.previewable?
            video.preview(resize_to_limit: [640, 360]).processed
        else
            return nil
        end
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
