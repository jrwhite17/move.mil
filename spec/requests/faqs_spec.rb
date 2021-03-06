RSpec.describe FaqsController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/faqs'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end
    end

    context 'when faqs exist' do
      let!(:faqs) { create_list(:faq, 2) }

      it 'displays a list of faqs' do
        get '/faqs'

        assert_select '.usa-accordion-bordered' do
          assert_select 'li:nth-child(1)' do
            assert_select '.usa-accordion-button', text: faqs.first.question
            assert_select '.usa-accordion-content', text: faqs.first.answer
          end

          assert_select 'li:nth-child(2) .usa-accordion-button', text: faqs.last.question
        end
      end
    end
  end
end
