[:BambooAgentInfoError, :BambooAgentPageSignatureError, :BambooMasterServerError, :BamgooAgentInfoError, :ExtraConfigurationParameterError, :FilePathError,
 :ForkingProvisionerDefinitionError, :MissingConfigurationParameterError, :NilConfigurationValueError, :NilVMError, :OpenNebulaTemplateError,
 :PathNilError, :PoolInformationError, :StageNumberNilError, :UnexpectedSecureValueError, :UnknownActionError,
 :UnknownConfigurationTypeError, :UnknownProvisioningStageError, :VMIPError, :UnknownConfigurationKeyValueError].each do |error|
  Object.const_set(error.to_s, Class.new(StandardError))
end
