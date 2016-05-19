#!/usr/bin/python

from __future__ import print_function

import argparse
import os
import smtplib
import time
from email.mime.text import MIMEText

def send_email(receiver, sender, password, smtp, port, subject, message):
    # Connect to SMTP server
    server = smtplib.SMTP(smtp, port)
    server.ehlo()
    server.starttls()
    server.login(sender, password)

    msg = MIMEText(message)
    msg['Subject'] = subject
    msg['From'] = sender
    msg['To'] = receiver

    server.sendmail(sender, receiver, msg.as_string())
    server.quit()

def main():
    parser = argparse.ArgumentParser(description="Send e-mail to destination, using SMTP+STARTTLS.")
    parser.add_argument("subject", help="e-mail subject")
    parser.add_argument("message", help="e-mail message")
    parser.add_argument("-s", "--sender", help="e-mail sender", required=True)
    parser.add_argument("-r", "--receiver", help="e-mail receiver. DEFAULT=same as sender")
    parser.add_argument("-w", "--password", help="sender password", required=True)
    parser.add_argument("-m", "--smtp", help="SMTP server URL", required=True)
    parser.add_argument("-p", "--port", help="SMTP server port. DEFAULT=587", default=587)

    args = parser.parse_args()

    receiver = args.receiver if args.receiver else args.sender

    print("Sender =", args.sender)
    print("Receiver =", receiver)
    print("Subject =", args.subject)
    print("Message:", args.message, sep="\n")

    send_email(receiver, args.sender, args.password, args.smtp, args.port, args.subject, args.message)

if __name__ == "__main__":
    main()
