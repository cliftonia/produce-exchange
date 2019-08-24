
CarrierWave.configure do |config|
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
    
    config.fog_credentials = {
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['AWS_APIKEY'],
        :aws_secret_access_key => ENV['AWS_APISKEY'],
        :region                => 'ap-southeast-2' # sydney
        # :host   => 's3-ap-southeast-2.amazonaws.com'
    }
    
    config.fog_provider = 'fog/aws'
    config.fog_directory    = ENV['AWS_S3']
    
    # config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
end

class ImageUploader < CarrierWave::Uploader::Base
    def filename
        "#{secure_token}.#{file.extension}" if original_filename.present?
    end
    
    protected
    def secure_token
        var = :"@#{mounted_as}_secure_token"
        model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end
    storage :fog
end

class Photo < ActiveRecord::Base
    belongs_to :item
    mount_uploader :image_link, ImageUploader

    # validates :image_link, presence: true
end