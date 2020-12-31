# name: delete-plugin
# about: A super simple plugin to allow users delete their own topics always
# version: 0.0.1
# authors: osvid

after_initialize do

  # change permissions on topic deletion
  module ::TopicGuardian
    def can_delete_topic?(topic)
      # alias_method :org_can_delete_topic?, :can_delete_topic?

      return true if !topic.trashed? &&
      (is_staff? || is_my_own?(topic) || is_category_group_moderator?(topic.category)) &&
      !topic.is_category_topic? &&
      !Discourse.static_doc_topic_ids.include?(topic.id)
            
    end   
  end
end
