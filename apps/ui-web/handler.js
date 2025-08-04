import AWS from "aws-sdk";

const s3 = new AWS.S3();

export const serve = async (event) => {
  const bucketName = `${process.env.STAGE}-ui-web-static-assets`;
  const key = event.path === "/" ? "index.html" : event.path.substring(1);

  try {
    const params = {
      Bucket: bucketName,
      Key: key,
    };

    const data = await s3.getObject(params).promise();

    const contentType = getContentType(key);

    return {
      statusCode: 200,
      headers: {
        "Content-Type": contentType,
        "Cache-Control": getCacheControl(key),
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
      body: data.Body.toString("base64"),
      isBase64Encoded: true,
    };
  } catch (error) {
    if (error.code === "NoSuchKey") {
      // For SPA routing, return index.html for 404s
      try {
        const indexParams = {
          Bucket: bucketName,
          Key: "index.html",
        };

        const indexData = await s3.getObject(indexParams).promise();

        return {
          statusCode: 200,
          headers: {
            "Content-Type": "text/html",
            "Cache-Control": "no-cache, no-store, must-revalidate",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "GET, OPTIONS",
          },
          body: indexData.Body.toString("base64"),
          isBase64Encoded: true,
        };
      } catch (indexError) {
        return {
          statusCode: 404,
          headers: {
            "Content-Type": "text/plain",
            "Access-Control-Allow-Origin": "*",
          },
          body: "Not Found",
        };
      }
    }

    return {
      statusCode: 500,
      headers: {
        "Content-Type": "text/plain",
        "Access-Control-Allow-Origin": "*",
      },
      body: "Internal Server Error",
    };
  }
};

function getContentType(key) {
  const ext = key.split(".").pop().toLowerCase();
  const contentTypes = {
    html: "text/html",
    js: "application/javascript",
    css: "text/css",
    json: "application/json",
    png: "image/png",
    jpg: "image/jpeg",
    jpeg: "image/jpeg",
    gif: "image/gif",
    svg: "image/svg+xml",
    ico: "image/x-icon",
    woff: "font/woff",
    woff2: "font/woff2",
    ttf: "font/ttf",
    eot: "application/vnd.ms-fontobject",
  };

  return contentTypes[ext] || "application/octet-stream";
}

function getCacheControl(key) {
  if (key === "index.html") {
    return "no-cache, no-store, must-revalidate";
  }

  const ext = key.split(".").pop().toLowerCase();
  const cacheableExtensions = [
    "js",
    "css",
    "png",
    "jpg",
    "jpeg",
    "gif",
    "svg",
    "ico",
    "woff",
    "woff2",
    "ttf",
  ];

  if (cacheableExtensions.includes(ext)) {
    return "public, max-age=31536000";
  }

  return "no-cache";
}
