# راهنمای پیکربندی

## تغییر پیکربندی WaterWall

می‌توانید پیکربندی WaterWall را با انتخاب گزینه مناسب از منو تغییر دهید:

1. اسکریپت را اجرا کنید:
    ```bash
    ./install_waterwall.sh
    ```
2. گزینه تغییر پیکربندی را انتخاب کنید:
    ```plaintext
    3. Change WaterWall configuration
    ```
3. اسکریپت فایل `config.json` را در ویرایشگر متنی باز می‌کند. تغییرات لازم را انجام داده و فایل را ذخیره کنید.

## گزینه‌های مدیریت سرور

### تنظیمات DNS

می‌توانید تنظیمات DNS را به Google، Cloudflare تغییر دهید یا به تنظیمات پیش‌فرض بازگردانید:

- **تغییر DNS به Google:**
    ```plaintext
    11. Change DNS to Google
    ```

- **تغییر DNS به Cloudflare:**
    ```plaintext
    12. Change DNS to Cloudflare
    ```

- **بازنشانی DNS به پیش‌فرض:**
    ```plaintext
    13. Reset DNS to default
    ```

### BBR (بهینه‌سازی TCP)

می‌توانید BBR را برای بهینه‌سازی TCP نصب یا حذف کنید:

- **نصب BBR:**
    ```plaintext
    8. Install BBR
    ```

- **حذف BBR:**
    ```plaintext
    9. Remove BBR
    ```

### بهینه‌سازی سرور

می‌توانید سرور را با نصب و راه‌اندازی `haveged` بهینه کنید:

- **بهینه‌سازی سرور:**
    ```plaintext
    10. Optimize server
    ```

برای گزینه‌های پیکربندی دقیق‌تر، لطفاً به [مستندات WaterWall](https://radkesvat.github.io/WaterWall-Docs/) مراجعه کنید.
