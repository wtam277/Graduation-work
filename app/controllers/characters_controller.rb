class CharactersController < ApplicationController
    before_action :set_comic
    before_action :set_character, only: [:update]

    def index
    end

    def update
    end

    private

    def set_comic
        @comic = Comic.find(params[:comic_id])
    end
end
