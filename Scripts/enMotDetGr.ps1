# Get the credential
$cred = Get-Credential admin

# Read IP addresses from the "ip2nd" file
$ipAddresses = Get-Content -Path .\ip3nd.txt

# Define the XML data
$xmlData = @"
<?xml version="1.0" encoding="UTF-8"?>
<MotionDetection version="2.0" xmlns="http://www.hikvision.com/ver20/XMLSchema">
    <enabled>true</enabled>
    <enableHighlight>true</enableHighlight>
    <samplingInterval>2</samplingInterval>
    <startTriggerTime>500</startTriggerTime>
    <endTriggerTime>500</endTriggerTime>
    <regionType>grid</regionType>
    <Grid>
        <rowGranularity>18</rowGranularity>
        <columnGranularity>22</columnGranularity>
    </Grid>
    <MotionDetectionLayout version="2.0" xmlns="http://www.hikvision.com/ver20/XMLSchema">
        <sensitivityLevel>60</sensitivityLevel>
        <layout>
            <gridMap>fffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffcfffffc</gridMap>
            <RegionList size="4">
                <Region>
                    <id>1</id>
                    <RegionCoordinatesList>
                        <RegionCoordinates>
                            <positionX>1</positionX>
                            <positionY>999</positionY>
                        </RegionCoordinates>
                        <RegionCoordinates>
                            <positionX>1000</positionX>
                            <positionY>999</positionY>
                        </RegionCoordinates>
                        <RegionCoordinates>
                            <positionX>1000</positionX>
                            <positionY>0</positionY>
                        </RegionCoordinates>
                        <RegionCoordinates>
                            <positionX>1</positionX>
                            <positionY>0</positionY>
                        </RegionCoordinates>
                    </RegionCoordinatesList>
                </Region>
            </RegionList>
        </layout>
        <targetType>human</targetType>
    </MotionDetectionLayout>
</MotionDetection>
"@

# Loop through each IP address and upload XML data
foreach ($ipAddress in $ipAddresses) {
    $url = "http://$ipAddress/ISAPI/System/Video/inputs/channels/1/MotionDetection"
    
    # Invoke the REST API to upload the XML data
    $response = Invoke-RestMethod -Method Put -Uri $url -Credential $cred -Body $xmlData -ContentType "application/xml"

    # Display the response
    $response
}
