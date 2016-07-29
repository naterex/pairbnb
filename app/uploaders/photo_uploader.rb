# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  require 'RMagick'
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog # for AWS S3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{mounted_as}/#{model.class.to_s.underscore}/#{model.id}"
    # "#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  def content_type_blacklist
    ['application/text', 'application/json']
  end

  # Process uploaded image would be scaled to be no larger than 400 by 400 pixels
  process :resize_to_fit => [770, 770]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :carousel do
    # fills exactly [x,y] dimensions
    process :resize_to_fill => [770, 300]
  end

  version :small do
    # fills exactly [x,y] dimensions
    process :resize_to_fill => [670, 500]
  end

  version :thumb do
    # fills exactly [x,y] dimensions
    process :resize_to_fill => [170, 100]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
