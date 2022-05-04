```bash
# Reset password
docker exec -it pihole pihole -a -p
```

# Change lookup rate limit

"Rate-limiting can easily be disabled by setting `RATE_LIMIT=0/0` in `/etc/pihole/pihole-FTL.conf`. If I want, say, to set a rate limit of 1 query per hour, the option should look like `RATE_LIMIT=1/3600`."

Reference: https://pi-hole.net/2021/02/16/pi-hole-ftl-v5-7-and-web-v5-4-released/#page-content
