extends Node

@export var Master_bank_asset: BankAsset
@export var SFX_bank_asset: BankAsset
@export var Music_bank_asset: BankAsset

var Master_bank: Bank
var SFX_bank: Bank
var Music_bank: Bank


func _ready() -> void:
	Master_bank = FMODStudioModule.get_studio_system().load_bank_file(Master_bank_asset.file_path, FMODStudioModule.FMOD_STUDIO_LOAD_BANK_NORMAL, false)
	SFX_bank = FMODStudioModule.get_studio_system().load_bank_file(SFX_bank_asset.file_path, FMODStudioModule.FMOD_STUDIO_LOAD_BANK_NORMAL, false)
	Music_bank = FMODStudioModule.get_studio_system().load_bank_file(Music_bank_asset.file_path, FMODStudioModule.FMOD_STUDIO_LOAD_BANK_NORMAL, false)
