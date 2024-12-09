FROM ubuntu:22.04

RUN apt-get update

RUN apt-get install -y curl

# Get Azure VPN Client
RUN curl -sSl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc

RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list

RUN apt-get update

RUN apt-get -y install microsoft-azurevpnclient

# Get firefox NON snap version
RUN curl -sSl https://packages.mozilla.org/apt/repo-signing-key.gpg | tee /etc/apt/keyrings/packages.mozilla.org.asc

RUN echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee /etc/apt/sources.list.d/mozilla.list

COPY ./mozilla /etc/apt/preferences.d/mozilla

RUN apt-get update

RUN apt-get -y install firefox

ENTRYPOINT ["/opt/microsoft/microsoft-azurevpnclient/microsoft-azurevpnclient"]
