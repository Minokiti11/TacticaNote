class Video < ApplicationRecord
    has_one_attached :video

    has_many :notes, dependent: :nullify
    has_many :timestamps, dependent: :nullify

    belongs_to :user, optional: true
    belongs_to :group, optional: true

    validate :acceptable_video

    private

    def acceptable_video
        return unless video.attached?

        acceptable_types = ['video/mp4', 'video/quicktime', 'video/x-msvideo', 'video/x-ms-wmv']
        unless acceptable_types.include?(video.content_type)
            errors.add(:video, 'はMP4、MOV、AVI、WMV形式でアップロードしてください')
        end
    end
end
