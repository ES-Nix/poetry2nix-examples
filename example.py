import pytchat
import time

chat = pytchat.create(video_id="uIx8l2xlYVY")
while chat.is_alive():
    print(chat.get().json())
    time.sleep(5)
    # Each chat item can also be output in JSON format.
    # for c in chat.get().items:
    #     print(c.json())
