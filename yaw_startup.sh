#!/bin/bash
# ============================================================
#  YET ANOTHER WORKFLOW (YAW) - CUSTOM STARTUP SCRIPT
#
#  This script runs automatically when your YAW pod boots.
#  Host this file on GitHub and paste the raw URL into the
#  YAW template's custom script environment variable.
#
#  The YAW template already downloads the base Wan 2.2 models,
#  so this script is just for YOUR custom models/nodes/LoRAs.
#
#  Required pod Environment Variables:
#    civitai_token = <your CivitAI API token>
#    hf_token      = <your HuggingFace read token>
# ============================================================
echo ""
echo "============================================================"
echo "  Running YAW Custom Startup Script..."
echo "============================================================"
echo ""

# --- Directories ---
mkdir -p /ComfyUI/models/loras

# ============================================================
#  DIFFUSION MODELS (Bernini-R)
# ============================================================
DIFF_DIR="/ComfyUI/models/diffusion_models"
mkdir -p "$DIFF_DIR"

download_model() {
  # $1 = url, $2 = output path
  [ -f "$2" ] && { echo "  ->  already exists: $(basename "$2")"; return 0; }
  echo "  ->  downloading $(basename "$2")..."
  curl -L -o "$2" "$1"
}

download_model "https://huggingface.co/Comfy-Org/Bernini-R/resolve/main/diffusion_models/wan2.2_bernini_r_high_noise_fp16.safetensors" "$DIFF_DIR/wan2.2_bernini_r_high_noise_fp16.safetensors"
download_model "https://huggingface.co/Comfy-Org/Bernini-R/resolve/main/diffusion_models/wan2.2_bernini_r_low_noise_fp16.safetensors" "$DIFF_DIR/wan2.2_bernini_r_low_noise_fp16.safetensors"

# ============================================================
#  CUSTOM NODES
# ============================================================
clone_node() {
  # $1 = folder name, $2 = git url
  if [ -d "$1" ]; then
    echo "  ->  already present: $1"
  else
    echo "  ->  cloning $1..."
    git clone "$2" "$1"
  fi
}

cd /ComfyUI/custom_nodes/ || exit 1
clone_node ComfyUI-RH-Bernini      "https://github.com/RH-RunningHub/ComfyUI-RH-Bernini.git"
clone_node ComfyUI-ColorCorrectGPU "https://github.com/boobkake22/ComfyUI-ColorCorrectGPU.git"

# ============================================================
#  PRIVATE LORAS (HuggingFace, authenticated)
# ============================================================
HF_TOKEN="${hf_token}"
if [ -z "$HF_TOKEN" ]; then
  echo "WARNING: hf_token not set — private LoRA downloads will fail."
fi

download_private_lora() {
  # $1 = full resolve URL, $2 = output filename
  local out="/ComfyUI/models/loras/$2"
  [ -f "$out" ] && { echo "  ->  already exists: $2"; return 0; }
  echo "  ->  downloading (private) $2..."
  curl -L -H "Authorization: Bearer ${HF_TOKEN}" -o "$out" "$1"
}

download_private_lora "https://huggingface.co/traderchords/KCharacter/resolve/main/WAN2.2_kasia_t2v_Character_HighNoise_v1.safetensors" "WAN2.2_kasia_t2v_Character_HighNoise_v1.safetensors"
download_private_lora "https://huggingface.co/traderchords/KCharacter/resolve/main/WAN2.2_kasia_t2v_Character_LowNoise_v1.safetensors" "WAN2.2_kasia_t2v_Character_LowNoise_v1.safetensors"

# --- CivitAI token ---
# Set this in your pod's Environment Variables as: civitai_token = your_token_here
CIVITAI_TOKEN="${civitai_token}"
if [ -z "$CIVITAI_TOKEN" ]; then
  echo "WARNING: civitai_token environment variable not set."
  echo "CivitAI LoRA downloads will fail. Set it in your pod's environment variables."
  echo ""
fi

# ============================================================
#  ADD YOUR CUSTOM LORAS BELOW THIS LINE

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/hard_cut_3_wan_i2v_high.safetensors \
  "https://civitai.com/api/download/models/2446376?type=Model&format=SafeTensor"
echo "  ->  hard_cut_3_wan_i2v_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2.2_i2v_gagging_high_v1.0.safetensors \
  "https://civitai.com/api/download/models/2407012?type=Model&format=SafeTensor"
echo "  ->  wan_2.2_i2v_gagging_high_v1.0..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2.2_i2v_gagging_low_v1.0.safetensors \
  "https://civitai.com/api/download/models/2407028?type=Model&format=SafeTensor"
echo "  ->  wan_2.2_i2v_gagging_low_v1.0..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/DR34ML4Y_I2V_14B_LOW_V2.safetensors \
  "https://civitai.com/api/download/models/2553271?type=Model&format=SafeTensor"
echo "  ->  DR34ML4Y_I2V_14B_LOW_V2..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/DR34ML4Y_I2V_14B_HIGH_V2.safetensors \
  "https://civitai.com/api/download/models/2553151?type=Model&format=SafeTensor"
echo "  ->  DR34ML4Y_I2V_14B_HIGH_V2..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/sh00tz_HN_75.safetensors \
  "https://civitai.com/api/download/models/2731730?type=Model&format=SafeTensor"
echo "  ->  sh00tz_HN_75..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/sh00tz_LN_75.safetensors \
  "https://civitai.com/api/download/models/2731744?type=Model&format=SafeTensor"
echo "  ->  sh00tz_LN_75..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/breasts-wan-e7.safetensors \
  "https://civitai.com/api/download/models/2156804?type=Model&format=SafeTensor"
echo "  ->  breasts-wan-e7..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2_2_anime_cumshot_aesthetics_low.safetensors \
  "https://civitai.com/api/download/models/2116027?type=Model&format=SafeTensor"
echo "  ->  wan_2_2_anime_cumshot_aesthetics_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2_2_anime_cumshot_aesthetics_high.safetensors \
  "https://civitai.com/api/download/models/2116008?type=Model&format=SafeTensor"
echo "  ->  wan_2_2_anime_cumshot_aesthetics_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Dreamlay_NSFW_T2V_LOW.safetensors \
  "https://civitai.red/api/download/models/2303113?type=Model&format=SafeTensor"
echo "  ->  Dreamlay_NSFW_T2V_LOW..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/dreamlay_t2v_nsfw_high.safetensors \
  "https://civitai.red/api/download/models/2303105?type=Model&format=SafeTensor"
echo "  ->  dreamlay_t2v_nsfw_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Deepthroat_facefuck_high.safetensors \
  "https://civitai.red/api/download/models/2517513?type=Model&format=SafeTensor"
echo "  ->  Deepthroat_facefuck_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Deepthroat_facefuck_low.safetensors \
  "https://civitai.red/api/download/models/2517548?type=Model&format=SafeTensor"
echo "  ->  Deepthroat_facefuck_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/XXXSmoothmix_high.safetensors \
  "https://civitai.red/api/download/models/2376136?type=Model&format=SafeTensor"
echo "  ->  XXXSmoothmix_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/XXXSmoothmix_low.safetensors \
  "https://civitai.red/api/download/models/2376143?type=Model&format=SafeTensor"
echo "  ->  XXXSmoothmix_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/French_Kiss_High.safetensors \
  "https://civitai.red/api/download/models/2445168?type=Model&format=SafeTensor"
echo "  ->  French_Kiss_High..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/French_kiss_low.safetensors \
  "https://civitai.red/api/download/models/2445176?type=Model&format=SafeTensor"
echo "  ->  French_kiss_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Ultimate_bbc_deepthroat_high.safetensors \
  "https://civitai.red/api/download/models/2370687?type=Model&format=SafeTensor"
echo "  ->  Ultimate_bbc_deepthroat_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Ultimate_bbc_deepthroat_low.safetensors \
  "https://civitai.red/api/download/models/2370744?type=Model&format=SafeTensor"
echo "  ->  Ultimate_bbc_deepthroat_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Ultimate_deepthroat_high.safetensors \
  "https://civitai.red/api/download/models/2325788?type=Model&format=SafeTensor"
echo "  ->  Ultimate_deepthroat_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Ultimate_deepthroat_low.safetensors \
  "https://civitai.red/api/download/models/2191446?type=Model&format=SafeTensor"
echo "  ->  Ultimate_deepthroat_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Lez_makeout_i2v.safetensors \
  "https://civitai.red/api/download/models/1792573?type=Model&format=SafeTensor"
echo "  ->  Lez_makeout_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Lez_makeout_t2v.safetensors \
  "https://civitai.red/api/download/models/1573366?type=Model&format=SafeTensor"
echo "  ->  Lez_makeout_t2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Wan_cumshot_i2v.safetensors \
  "https://civitai.red/api/download/models/1602715?type=Model&format=SafeTensor"
echo "  ->  Wan_cumshot_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Wan_cumshot_t2v_high.safetensors \
  "https://civitai.red/api/download/models/2077123?type=Model&format=SafeTensor"
echo "  ->  Wan_cumshot_t2v_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Wan_cumshot_t2v_low.safetensors \
  "https://civitai.red/api/download/models/2077119?type=Model&format=SafeTensor"
echo "  ->  Wan_cumshot_t2v_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Anal_insertion.safetensors \
  "https://civitai.red/api/download/models/2055564?type=Model&format=SafeTensor"
echo "  ->  Anal_insertion..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Female_Genital_help_i2v_t2v.safetensors \
  "https://civitai.red/api/download/models/2012120?type=Model&format=SafeTensor"
echo "  ->  Female_Genital_help_i2v_t2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/WAN_POVBLOWJOB_I2V.safetensors \
  "https://civitai.red/api/download/models/2021249?type=Model&format=SafeTensor"
echo "  ->  WAN_POVBLOWJOB_I2V..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/WAN_POVBLOWJOB_T2V.safetensors \
  "https://civitai.red/api/download/models/2021242?type=Model&format=SafeTensor"
echo "  ->  WAN_POVBLOWJOB_T2V..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Wan_facial_cumonface_i2v_t2v.safetensors \
  "https://civitai.red/api/download/models/1973462?type=Model&format=SafeTensor"
echo "  ->  Wan_facial_cumonface_i2v_t2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Wan_Thiccum.safetensors \
  "https://civitai.red/api/download/models/1860691?type=Model&format=SafeTensor"
echo "  ->  Wan_Thiccum..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Fingering_for_wan_i2v.safetensors \
  "https://civitai.red/api/download/models/1694292?type=Model&format=SafeTensor"
echo "  ->  Fingering_for_wan_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Fingering_for_wan_t2v.safetensors \
  "https://civitai.red/api/download/models/1633278?type=Model&format=SafeTensor"
echo "  ->  Fingering_for_wan_t2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Spanking_for_wan.safetensors \
  "https://civitai.red/api/download/models/1674260?type=Model&format=SafeTensor"
echo "  ->  Spanking_for_wan..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Exotic_Breast_massage.safetensors \
  "https://civitai.red/api/download/models/1410507?type=Model&format=SafeTensor"
echo "  ->  Exotic_Breast_massage..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Foot_focus_feetonchest.safetensors \
  "https://civitai.red/api/download/models/1610463?type=Model&format=SafeTensor"
echo "  ->  Foot_focus_feetonchest..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Ahegao_Face.safetensors \
  "https://civitai.red/api/download/models/1571626?type=Model&format=SafeTensor"
echo "  ->  Ahegao_Face..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/POV_doggystyle.safetensors \
  "https://civitai.red/api/download/models/1545040?type=Model&format=SafeTensor"
echo "  ->  POV_doggystyle..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Facials_cumonface_t2v_i2v.safetensors \
  "https://civitai.red/api/download/models/1542133?type=Model&format=SafeTensor"
echo "  ->  Facials_cumonface_t2v_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/breast_slider_low.safetensors \
  "https://civitai.red/api/download/models/2235403?fileId=2128297"
echo "  ->  breast_slider_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/breast_slider_high.safetensors \
  "https://civitai.red/api/download/models/2235351?fileId=2128288"
echo "  ->  breast_slider_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Breasts_large_areolas.safetensors \
  "https://civitai.red/api/download/models/2218410?fileId=2111415"
echo "  ->  Breasts_large_areolas..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/Reverse_cowgirl_high_i2v.safetensors \
  "https://civitai.red/api/download/models/2156392?fileId=2049798"
echo "  ->  Reverse_cowgirl_high_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/reverse_cowgirl_low_i2v.safetensors \
  "https://civitai.red/api/download/models/2156435?fileId=2049795"
echo "  ->  reverse_cowgirl_low_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/reverse_cowgirl_high_t2v.safetensors \
  "https://civitai.red/api/download/models/2188529?fileId=2081482"
echo "  ->  reverse_cowgirl_high_t2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/reverse_cowgirl_low_t2v.safetensors \
  "https://civitai.red/api/download/models/2188552?fileId=2081506"
echo "  ->  reverse_cowgirl_low_t2v..."

curl -L \
  -o /ComfyUI/models/loras/wan2.2-i2v-high-oral-insertion-v1.0.safetensors \
  "https://huggingface.co/rahul7star/wan2.2Lora/resolve/1d1e553d07c1bb0e91765752413c4857e31df299/wan2.2/wan2.2-i2v-high-oral-insertion-v1.0.safetensors?download=true"
echo "  ->  wan2.2-i2v-high-oral-insertion-v1.0..."

curl -L \
  -o /ComfyUI/models/loras/wan2.2-i2v-low-oral-insertion-v1.0.safetensors \
  "https://huggingface.co/rahul7star/wan2.2Lora/resolve/1d1e553d07c1bb0e91765752413c4857e31df299/wan2.2/wan2.2-i2v-low-oral-insertion-v1.0.safetensors?download=true"
echo "  ->  wan2.2-i2v-low-oral-insertion-v1.0..."

ADD YOUR CUSTOM LORAS ABOVE THIS LINE
# ============================================================
echo ""
echo "============================================================"
echo "  YAW custom startup complete."
echo "============================================================"
echo ""
