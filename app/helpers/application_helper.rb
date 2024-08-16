module ApplicationHelper
    def format_embed_video(video)
        video.gsub('watch?v=', 'embed/')
    end
end
