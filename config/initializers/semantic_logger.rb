# frozen_string_literal: true
Rails.logger = SemanticLogger[Rails.application.class.module_parent_name.to_s]
