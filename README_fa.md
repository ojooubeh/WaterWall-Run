
##### README_fa.md

```markdown
# اسکریپت راه‌اندازی WaterWall

## توضیحات

این اسکریپت یک راه‌اندازی جامع برای WaterWall فراهم می‌کند که شامل گزینه‌های نصب، به‌روزرسانی و پیکربندی می‌شود. همچنین شامل امکانات مدیریت سرور مانند تنظیمات DNS و بهینه‌سازی TCP است.

## ویژگی‌ها

- نصب و به‌روزرسانی WaterWall
- تغییر پیکربندی WaterWall
- شروع و توقف سرویس WaterWall
- حذف نصب WaterWall
- مدیریت سرور (DNS، BBR، بهینه‌سازی)
- تلاش مجدد خودکار برای دانلود با استفاده از WARP در صورت عدم موفقیت دانلود اولیه

## نصب

برای نصب اسکریپت و پیش‌نیازهای آن، به [راهنمای نصب](INSTALL_fa.md) مراجعه کنید.

```bash
sudo apt install -y dos2unix git && git clone https://github.com/ojooubeh/WaterWall-Run.git && cd WaterWall-Run && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
