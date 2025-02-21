# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://tactica-note.com"

SitemapGenerator::Sitemap.create do
  # トップページは自動的に追加されます（優先度: 1.0）

  # 静的ページ
  add page_path(1), priority: 0.4, changefreq: 'monthly'
  add new_contact_path, priority: 0.8, changefreq: 'monthly'
  
  # 認証関連
  add new_user_session_path, priority: 0.7, changefreq: 'monthly'
  add new_user_registration_path, priority: 0.7, changefreq: 'monthly'
  
  # ユーザー関連
  add my_page_path, priority: 0.7, changefreq: 'weekly'
  
  # 機能ページ
  add notes_path, priority: 0.6, changefreq: 'daily'
  add practices_path, priority: 0.6, changefreq: 'daily'
  add groups_path, priority: 0.6, changefreq: 'daily'
  add videos_path, priority: 0.6, changefreq: 'daily'
  
  # 動的コンテンツ
  Note.find_each do |note|
    add note_path(note), priority: 0.5, changefreq: 'weekly', lastmod: note.updated_at
  end
  
  Group.find_each do |group|
    add group_path(group), priority: 0.5, changefreq: 'weekly', lastmod: group.updated_at
  end
  
  Practice.find_each do |practice|
    add practice_path(practice), priority: 0.5, changefreq: 'weekly', lastmod: practice.updated_at
  end
  
  Video.find_each do |video|
    add video_path(video), priority: 0.5, changefreq: 'weekly', lastmod: video.updated_at
  end
end
