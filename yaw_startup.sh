#!/bin/bash
# ============================================================
#  YET ANOTHER WORKFLOW (YAW) - CUSTOM STARTUP SCRIPT
#
#  This script runs automatically when your YAW pod boots.
#  Host this file on GitHub and paste the raw URL into the
#  YAW template's custom script environment variable.
#
#  The YAW template already downloads the base Wan 2.2 models,
#  so this script is just for YOUR custom LoRAs on top of that.
#
#  HOW TO ADD A LORA:
#  - From CivitAI: copy the curl block below and update the
#    model ID and output filename
#  - From HuggingFace: use the hf download command pattern
# ============================================================

echo ""
echo "============================================================"
echo "  Running YAW Custom Startup Script..."
echo "============================================================"
echo ""

# --- Directories ---
mkdir -p /ComfyUI/models/loras

# Pull CivitAI token from RunPod environment variable
# Set this in your pod's Environment Variables as: civitai_token = your_token_here
CIVITAI_TOKEN="${civitai_token}"

if [ -z "$CIVITAI_TOKEN" ]; then
  echo "WARNING: civitai_token environment variable not set."
  echo "CivitAI LoRA downloads will fail. Set it in your pod's environment variables."
  echo ""
fi

# ============================================================
#  ADD YOUR CUSTOM LORAS BELOW THIS LINE
#  Copy and paste a block for each LoRA you want to add
# ============================================================

# --- CIVITAI LORA TEMPLATE ---
# Uncomment and fill in to add a CivitAI LoRA:
#
# echo "  -> Your LoRA Name Here..."
# curl -L \
#   -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
#   -o /ComfyUI/models/loras/YOUR_LORA_FILENAME.safetensors \
#   "https://civitai.com/api/download/models/REPLACE_WITH_MODEL_ID?type=Model&format=SafeTensor"


# --- HUGGINGFACE LORA TEMPLATE ---
# Uncomment and fill in to add a HuggingFace LoRA:
#
# echo "  -> Your LoRA Name Here..."
# hf download REPO/NAME \
#   filename.safetensors \
#   --local-dir /ComfyUI/models/loras


# ============================================================
#  ADD YOUR CUSTOM LORAS ABOVE THIS LINE
# ============================================================

echo ""
echo "============================================================"
echo "  YAW custom startup complete."
echo "============================================================"
echo ""
