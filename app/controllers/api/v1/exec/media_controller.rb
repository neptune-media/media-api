# frozen_string_literal: true

module Api
  module V1
    module Exec
      class MediaController < ApplicationController
        def import
          id = params[:id]
          if id.present?
            sb = StorageBackend.find id
            MediaImportScanWorker.perform_async sb.id if sb.present?
          else
            StorageBackend.all.each do |sb|
              MediaImportScanWorker.perform_async sb.id
            end
          end
        end
      end
    end
  end
end
