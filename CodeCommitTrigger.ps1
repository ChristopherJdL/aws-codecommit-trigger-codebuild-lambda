# PowerShell script file to be executed as a AWS Lambda function.
#
# When executing in Lambda the following variables will be predefined.
#   $LambdaInput - A PSObject that contains the Lambda function input data.
#   $LambdaContext - An Amazon.Lambda.Core.ILambdaContext object that contains information about the currently running Lambda environment.
#
# The last item in the PowerShell pipeline will be returned as the result of the Lambda function.
#
# To include PowerShell modules with your Lambda function, like the AWS.Tools.S3 module, add a "#Requires" statement
# indicating the module and version. If using an AWS.Tools.* module the AWS.Tools.Common module is also required.

#Requires -Modules @{ModuleName='AWS.Tools.Common';ModuleVersion='4.1.29.0'}
#Requires -Modules @{ModuleName='AWS.Tools.CodeBuild';ModuleVersion='4.1.29.0'}

# Uncomment to send the input event to CloudWatch Logs
# Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)

# A CodeCommit Trigger can receive multiple records per execution
try{
    
foreach ($record in $LambdaInput.Records) {
    $codeBuildProjectName = $record.customData

    Start-CBBuild $codeBuildProjectName
}

}
catch {
      Write-Host $_
}

