package pageobjects.Instagram.UserData;

public class PostInfo {
    private String type;
    private int imageCount;
    private int videoCount;

    public PostInfo(String type, int imageCount, int videoCount) {
        this.type = type;
        this.imageCount = imageCount;
        this.videoCount = videoCount;
    }

    public String getType() {
        return type;
    }

    public int getImageCount() {
        return imageCount;
    }

    public int getVideoCount() {
        return videoCount;
    }

    @Override
    public String toString() {
        return "Post Type: " + type + "\nImages: " + imageCount + "\nVideos: " + videoCount;
    }
}
