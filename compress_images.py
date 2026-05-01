import os
from PIL import Image

Image.MAX_IMAGE_PIXELS = None
folder = 'assets/Project1'

for filename in os.listdir(folder):
    if filename.endswith(('.png', '.jpg', '.jpeg')):
        filepath = os.path.join(folder, filename)
        file_size = os.path.getsize(filepath)
        
        # Only compress files larger than 1MB
        if file_size > 1024 * 1024:
            print(f"Compressing {filename} (Original size: {file_size / 1024 / 1024:.2f} MB)")
            try:
                with Image.open(filepath) as img:
                    # Convert to RGB if it's RGBA and saving as JPEG, but we'll stick to PNG or convert format if needed
                    # Let's resize it if it's huge
                    width, height = img.size
                    
                    if width > 2000 or height > 2000:
                        ratio = min(2000 / width, 2000 / height)
                        new_size = (int(width * ratio), int(height * ratio))
                        img = img.resize(new_size, Image.Resampling.LANCZOS)
                        
                    # Save as WebP or optimized PNG
                    # We will overwrite the PNG but optimized
                    img.save(filepath, optimize=True, quality=80)
                print(f"Done: {filename}")
            except Exception as e:
                print(f"Error compressing {filename}: {e}")
