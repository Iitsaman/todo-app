
#!/bin/bash

# Check if bucket name is provided
if [ -z "$1" ]; then
    echo "Error: Bucket name not provided"
    exit 1
fi

# Check if distribution ID is provided
if [ -z "$2" ]; then
    echo "Error: CloudFront distribution ID not provided"
    exit 1
fi

BUCKET_NAME="$1"
DISTRIBUTION_ID="$2"

echo "Starting deployment to bucket: $BUCKET_NAME"

echo "Building the frontend"
npm run build


echo "Uploading the build to S3..."
aws s3 sync dist/ "s3://$BUCKET_NAME/" --delete

echo "Invalidating Cloudfront Cache..."
aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION_ID" --paths "/*"

echo "Frontend deployed successfully ✅"