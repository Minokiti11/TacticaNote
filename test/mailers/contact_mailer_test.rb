require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  test "inquiry" do
    mail = ContactMailer.inquiry
    assert_equal "Inquiry", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "received" do
    mail = ContactMailer.received
    assert_equal "Received", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
