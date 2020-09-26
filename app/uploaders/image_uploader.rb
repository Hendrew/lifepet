class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    def public_id
      "#{store_dir}/#{model.id}"
    end

    def filename
      "#{public_id}.#{file.extension}" if original_filename.present?
    end

    def store_dir
      "lifepet/uploads/#{model.class.to_s.underscore}/#{mounted_as}"
    end

    process tags: ['animal']
    process resize_to_fit: [660, 660]

    version :medium do
      eager
      process resize_to_fit: [330, 330]
      cloudinary_transformation quality: 80
    end
  else
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    process resize_to_fit: [660, 660]

    version :medium do
      process resize_to_fit: [330, 330]
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
