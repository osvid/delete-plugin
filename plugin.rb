# name: delete-plugin
# about: A super simple plugin to allow users delete their own topics always
# version: 0.0.1
# authors: osvid

after_initialize do

  # hide posts from the /raw/tid/pid route
  module ::TopicGuardian
    # alias_method :org_can_see_post?, :can_see_post?

    def can_delete_topic?(topic)
      !topic.trashed? &&
      (is_staff? || (is_my_own?(topic) || is_category_group_moderator?(topic.category)) &&
      !topic.is_category_topic? &&
      !Dis0course.static_doc_topic_ids.include?(topic.id)
    end
  end
end
