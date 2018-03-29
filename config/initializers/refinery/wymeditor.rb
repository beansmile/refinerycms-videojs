Refinery::Wymeditor.configure do |config|

# Add extra tags to the wymeditor whitelist e.g. = {"tag"=> {"attributes"=> {"1"=> "href"}}} or just {"tag"=> {}}
# config.whitelist_tags =  {"span"=> {
# "attributes"=> {
# "1"=> "data-tooltip"
# }}}
  config.whitelist_tags =
    {"video" => {
      "attributes"=> {
        "0"=> "width",
        "1"=> "height",
        "2"=> "poster",
        "3"=> "data-setup",
        "4"=> "autoplay",
        "5"=> "controls",
        "6"=> "loop",
        "7"=> "muted",
        "8"=> "poster",
        "9"=> "preload",
        "10"=> "src"
      }
    },
     "source"=> {
       "attributes"=> {
         "0"=> "src",
         "1"=> "type",
         "2"=> "media"
       },
       "inside" => {
         "0" => "audio",
         "1" => "video"
       }
     }
    }
end

