from pprint import pprint
import sys
import telepot
bot = telepot.Bot('999999:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
bot.getMe()
#response = bot.getUpdates()
#pprint(response)
bot.sendMessage(99999999, 'motion detected')
bot.sendPhoto(99999999,open(str(sys.argv[1]), 'rb'))

