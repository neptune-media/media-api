# frozen_string_literal: true

module Api
  module V1
    module Exec
      # Handles media actions
      class MediaController < ApplicationController
        def import
          id = params[:id]
          if id.present?
            sb = StorageBackend.find id
            MediaImportScanWorker.perform_async sb.id if sb.present?
          else
            StorageBackend.all.each do |s|
              MediaImportScanWorker.perform_async s.id
            end
          end
        end
      end
    end
  end
end
