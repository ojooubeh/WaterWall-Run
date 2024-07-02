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

### روش 1: دانلود و اجرای اسکریپت با curl

```bash
sudo apt update && sudo apt install -y dos2unix curl git && curl -L https://raw.githubusercontent.com/ojooubeh/WaterWall-Run/main/install_waterwall.sh -o install_waterwall.sh && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
```
#روش 2: دانلود و اجرای اسکریپت با wget
```bash
sudo apt update && sudo apt install -y dos2unix wget git && wget https://raw.githubusercontent.com/ojooubeh/WaterWall-Run/main/install_waterwall.sh -O install_waterwall.sh && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
```
## پیکربندی

برای گزینه‌های پیکربندی دقیق، به [راهنمای پیکربندی](CONFIG_fa.md) مراجعه کنید.

## استفاده

اسکریپت را اجرا کرده و دستورالعمل‌های روی صفحه را برای مدیریت WaterWall و تنظیمات سرور دنبال کنید.

## تشکر

این پروژه بر اساس کار عالی انجام شده توسط [پروژه WaterWall](https://github.com/radkesvat/WaterWall) ساخته شده است. لطفاً به [مستندات آن‌ها](https://radkesvat.github.io/WaterWall-Docs/) برای جزئیات بیشتر مراجعه کنید.

## کارهای آینده

هدف ما این است که فرآیند پیکربندی را در به‌روزرسانی‌های آینده به صورت خودکار انجام دهیم.
