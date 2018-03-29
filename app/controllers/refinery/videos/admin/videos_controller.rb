module Refinery
  module Videos
    module Admin
      class VideosController < ::Refinery::AdminController

        crudify :'refinery/videos/video',
                :title_attribute => 'title',
                :order => 'position ASC',
                :sortable => true

        before_action :set_embedded, :only => [:new, :create]

        def show
          @video = Video.find(params[:id])
        end

        def new
          @video = Video.new
          @video.video_files.build
        end

        def insert
          search_all_videos if searching?
          find_all_videos
          paginate_videos
        end

        def append_to_wym
          return if params[:video_id].blank?
          @video = Video.find(params[:video_id])
          params['video'].each do |key, value|
            @video.config[key.to_sym] = value
          end
          @html_for_wym = @video.to_html
        end

        def dialog_preview
          @video = Video.find(params[:id].delete('video_'))
           w, h = @video.config[:width], @video.config[:height]
          @video.config[:width], @video.config[:height] = 300, 200
          @embedded = true if @video.use_shared
          @preview_html = @video.to_html
          @video.config[:width], @video.config[:height] = w, h
        end

        def video_params
          params.require(:video).permit(permitted_video_params)
        end

        private

        def paginate_videos
          @videos = @videos.paginate(:page => params[:page], :per_page => Video.per_page(true))
        end

        def set_embedded
          @embedded = true if params['embedded']
        end

        def permitted_video_params
          [
            :id, :title, :poster_id, :image_alt, :position, :config, :embed_tag, :use_shared,
            :autoplay, :width , :height, :controls, :preload, :loop,
            video_files_attributes: [:id, :file, :file_mime_type, :position, :use_external, :external_url, :_destroy]
          ]

        end
      end
    end
  end
end
