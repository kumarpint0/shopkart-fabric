
setGlobalsForOrderer() {
    export CORE_PEER_LOCALMSPID="OrdererMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/network/crypto-config/ordererOrganizations/shopkart.com/orderers/orderer.shopkart.com/msp/tlscacerts/tlsca.shopkart.com-cert.pem
    export CORE_PEER_MSPCONFIGPATH=${PWD}/network/crypto-config/ordererOrganizations/shopkart.com/users/Admin@shopkart.com/msp

}
# setGlobalsForOrderer

setGlobalsForPeer0amazon() {
    export CORE_PEER_LOCALMSPID="amazonMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_AMAZON_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/network/crypto-config/peerOrganizations/amazon.shopkart.com/users/Admin@amazon.shopkart.com/msp
    export CORE_PEER_MSPCONFIGPATH=${PWD}/network/crypto-config/peerOrganizations/amazon.shopkart.com/peers/peer0.amazon.shopkart.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}
# setGlobalsForPeer0amazon
setGlobalsForPeer1amazon() {
    export CORE_PEER_LOCALMSPID="amazonMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_AMAZON_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/network/crypto-config/peerOrganizations/amazon.shopkart.com/users/Admin@amazon.shopkart.com/msp
    export CORE_PEER_ADDRESS=localhost:8051

}

# setGlobalsForPeer1amazon

setGlobalsForPeer0flipkart() {
    export CORE_PEER_LOCALMSPID="flipkartMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_FLIPKART_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/network/crypto-config/peerOrganizations/flipkart.shopkart.com/users/Admin@flipkart.shopkart.com/msp
    export CORE_PEER_ADDRESS=localhost:9051

}
# setGlobalsForPeer0flipkart
setGlobalsForPeer1flipkart() {
    export CORE_PEER_LOCALMSPID="flipkartMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_FLIPKART_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/network/crypto-config/peerOrganizations/flipkart.shopkart.com/users/Admin@flipkart.shopkart.com/msp
    export CORE_PEER_ADDRESS=localhost:10051

}

# setGlobalsForPeer1flipkart
presetup() {
    echo Vendoring Go dependencies ...
    pushd ./chaincode/users
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}

# presetup


CHANNEL_NAME="shopkartchannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_SRC_PATH="./chaincode/users"
CC_NAME="Users"

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    # setGlobalsForPeer0amazon
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged on peer0.amazon ===================== "
}
# packageChaincode

installChaincode() {
    setGlobalsForPeer0amazon
    # peer lifecycle chaincode install ${CC_NAME}.tar.gz
    # echo "===================== Chaincode is installed on peer0.amazon ===================== "

    # setGlobalsForPeer1amazon
    # peer lifecycle chaincode install ${CC_NAME}.tar.gz
    # echo "===================== Chaincode is installed on peer1.amazon ===================== "

    # setGlobalsForPeer0flipkart
    # peer lifecycle chaincode install ${CC_NAME}.tar.gz
    # echo "===================== Chaincode is installed on peer0.flipkart ===================== "

    # setGlobalsForPeer1flipkart
    # peer lifecycle chaincode install ${CC_NAME}.tar.gz
    # echo "===================== Chaincode is installed on peer1.flipkart ===================== "
}
installChaincode
