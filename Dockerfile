# 1. استخدام نسخة توم كات جاهزة كقاعدة
FROM tomcat:9.0-jdk8-openjdk

# 2. إضافة ملف الـ WAR الخاص بك إلى مجلد التوزيع (webapps)
# ملاحظة: تأكد من وجود ملف باسم sample.war في نفس المجلد
COPY sample.war /usr/local/tomcat/webapps/

# 3. إخبار Docker أننا سنستخدم بورت 8080 (البورت الافتراضي للتوم كات داخل الحاوية)
EXPOSE 8080

# 4. تشغيل السيرفر تلقائياً عند بدء الحاوية
CMD ["catalina.sh", "run"]
