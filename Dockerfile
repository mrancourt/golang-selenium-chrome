FROM golang

#==================
# Environment
#==================
ENV CHROMEDRIVER_VERSION=2.33
ENV DISPLAY=:99

#==================
# Apt dependencies
#==================
RUN apt-get update && \
	apt-get install nano git make unzip python-pip xvfb -y
# python dependencies
RUN pip install selenium chromedriver pyvirtualdisplay

#==================
# Chrome
#==================
RUN apt-get install gconf-service libasound2 libgconf-2-4 libgtk-3-0 libnspr4 \
			libxtst6 fonts-liberation libnss3 lsb-release xdg-utils libxss1 \
			libappindicator1 libindicator7 -y
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb

#==================
# ChromeDriver
#==================
RUN wget https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod +x chromedriver
RUN mv -f chromedriver /opt/chromedriver
RUN ln -s /opt/chromedriver /usr/bin/chromedriver

#==================
# Virtual Display
#==================
RUN Xvfb :99 &

#==================
# Cleaning up
#==================
RUN rm google-chrome*.deb
RUN rm chromedriver_linux*.zip
